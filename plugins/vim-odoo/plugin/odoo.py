#!/usr/bin/python3
# Interface from vim to admin scripts
import urllib3
import requests
from pathlib import Path
import importlib
from types import ModuleType
import os
import sys
import threading

def do_reload(module):
    if os.getenv("RELOAD_ODOO_MODULES", "") == "1":
        importlib.reload(module)

def attribute_nam(method):
    def wrapper(*args, **kwargs):
        result = method(*args, **kwargs)

        return result
    return wrapper

def __load_modules():
    odoo_home = os.getenv("ODOO_HOME")
    if not odoo_home:
        print("ODOO_HOME not set")
        return
    sys.path.append(str(Path(odoo_home) / 'tools'))
    try:
        import odoo_tools
        from odoo_tools import module_tools
        from odoo_tools import consts
        do_reload(odoo_tools)
        do_reload(module_tools)
        do_reload(consts)
    except Exception as e:
        import traceback
        msg = traceback.format_exc()
        Path("/tmp/ex").write_text(msg)
        print(msg)
        print(str(e))
        return False
    return True

def _get_customs_root(path):
    if not __load_modules():
        print("Odoo modules not loaded.")
        return
    from odoo_tools import _get_customs_root as odoog
    res = odoog(Path(path))
    if res:
        return Path(res)

def execute_from_vim(vim, cmd, filepath=None, customs=None, db=None, version=None, path=None, parent_path=None, module_name=None):

    if not __load_modules():
        print("Odoo modules not loaded.")
        return
    from odoo_tools import consts
    from odoo_tools import odoo_config
    from odoo_tools.module_tools import Module, Modules
    from odoo_tools import module_tools as mt
    from odoo_tools import _get_customs_root
    odoo_parser = parser_module()
    current_customs = odoo_config.current_customs
    VERSIONS = consts.VERSIONS

    lineno = int(vim.eval("line(\".\")"))
    filepath = filepath or parent_path or path or os.getcwd()
    filepath = filepath and Path(filepath).resolve().absolute()
    customs_dir = _get_customs_root(Path(filepath))
    try:
        filepath_rel = filepath.relative_to(customs_dir)
    except Exception:
        filepath_rel = ""

    try:
        if cmd == 'just_load':
            return {
                'odoo_config': odoo_config,
            }
        if customs_dir:
            if cmd == 'update_view_in_db':
                mt.update_view_in_db_in_debug_file(filepath_rel, lineno)

            elif cmd == 'update_module_file':
                Module(filepath).update_module_file()

            elif cmd == 'update_module_full':
                mt.update_module(filepath, full=True)

            elif cmd == 'update_module':
                mt.update_module(filepath)

            elif cmd == 'export_langs':
                Module(filepath).export_lang(filepath, LANG='de_DE')

            elif cmd == 'quick_restart':
                mt.restart(quick=True)

            elif cmd == 'restart':
                mt.restart()

            elif cmd == "get_all_customs":
                return mt.get_all_customs()

            elif cmd == "get_current_customs":
                return current_customs()

            elif cmd == "get_versions":
                return VERSIONS

            elif cmd == "make_customs":
                mt.make_customs(customs=customs, version=version)

            elif cmd == 'make_module':
                mt.make_module(
                    parent_path=parent_path,
                    module_name=module_name,
                )

            elif cmd == 'filechanged':
                if filepath.suffix == '.po':
                    Module(filepath).apply_po_file(filepath)

                odoo_parser.update_cache(filepath)

            elif cmd == 'update_cache':
                odoo_parser.update_cache()

            elif cmd == 'run_test':
                mt.run_test_file(path=filepath_rel)

            elif cmd == 'run_last_test':
                mt.run_test_file(path=None)
            else:
                raise Exception("Invalid command: {}".format(cmd))

    except Exception:
        raise

def goto_inherited_view(vim, filepath, line, content):
    if not __load_modules():
        return
    return parser_module().goto_inherited_view(filepath, line, content)

def parser_module():
    if not __load_modules():
        return
    from odoo_tools import odoo_parser
    do_reload(odoo_parser)
    return odoo_parser

def config():
    if not __load_modules():
        return
    from odoo_tools import odoo_config
    return odoo_config
