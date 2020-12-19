function! python#Runcurrentscript()
python << PYTHONEOF
import tempfile
import vim
import os
current_file = vim.current.buffer.name
path = os.path.dirname(current_file)
exepath = os.path.join(
	path,
	os.path.basename(tempfile.mktemp()),
)
with open(exepath, 'w') as f:
	f.write("#!/bin/bash\n")
	f.write("python  \"{}\"\n".format(os.path.basename(current_file)))
	f.write("read -p 'Press any key to continue' test;")
os.system('chmod a+x "{}"'.format(exepath))
vim.command(":edit term://{}".format(exepath))
PYTHONEOF
endfunction

command! PyRunCurrentFile call python#Runcurrentscript()
