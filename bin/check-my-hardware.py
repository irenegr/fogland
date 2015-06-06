import string, os, sys

# SanderJ
# 2009-11-09
# 2009-12-20: script now takes care of PAE-kernels, and will advice to use it, even on x86_64-bit CPUs
# 2009-12-21: code clean up
# 2010-04-04: taking care of running within a Xen virtual machine. Ignore dmidecode's line that says "Range Size: 4194176 MB"
# 2010-04-05: detection of a VirtualBox virtual machine. As a test: also look at 'modified' usable memory
# 2010-04-06: more information a memory differences / lost
# 2011-03-13: run lshw to show more memory info. Slow but informative
# 2012-03-05: workaround if dmesg does not show "modified" lines
# 2012-06-03: If not not root, don't exit, but see what's possible
# 2013-02-22: Handle new format of /var/log/dmesg in Linux 3.5. Typo solved. And another type
# 2014-03-16: Check if running on X86 (dmidecode and lshw are not availabel on ARM). Print additional info from dmidecode

def print_output_from_cmd(cmd):
	for thisline in os.popen(cmd).readlines():
		print thisline,


print sys.argv[0], "- version: SJ 2014-03-16"

if os.popen('uname -m').readline().find('x86') < 0:
	print "I can only run on x86. Stopping. Just this info:"
	freetotal = int(os.popen('free -m | grep -i mem').readline().split()[1])
	print "Memory seen by OS", freetotal, "MB"
	sys.exit(0)


if os.popen('whoami').readline().strip() == 'root' :
	print "OK, you're root"
	root = True
else:
	root = False

print "ANALYSIS:"


'''
sander@quirinius:~$ sudo dmidecode | egrep -A8 -i -e "Memory Device" | grep -i MB
[sudo] password for sander: 
	Size: 1024 MB
sander@quirinius:~$
'''

dimmtotal = 0
counter = 0

if root:
	cmd = 'dmidecode | egrep -A8 -i -e "Memory Device" | grep -i MB | grep -vi range'
	for thisline in os.popen(cmd).readlines():
		counter += 1
		dimmtotal += int(thisline.split()[1])
	print "Total of physical memory modules found", dimmtotal, "MB", "in", counter, "memory module(s)"

xen = False

if counter == 0:
	if root: 
		print "No lines with 'MB' found. Am I in a virtual machine that does not support 'dmidecode'?"

	if os.popen('cat /var/log/dmesg | grep -i xen').readlines() :
		xen = True
		print "... yes, I'm in a Xen virtual machine"

	if os.popen('cat /var/log/dmesg | grep -i vbox').readlines() :
		virtualbox = True
		print "... yes, I'm in a VirtualBox virtual machine"


# maybe some reading to do on http://www.dmo.ca/blog/detecting-virtualization-on-linux/

if not xen :
	cmd = 'cat /var/log/dmesg | grep -i bios-e820 | grep -i usable'
else :
	cmd = 'cat /var/log/dmesg | grep -i xen | grep -i usable'
biostotal = 0
for thisline in os.popen(cmd).readlines():
	# Format of the lines:

	# Linux 3.5
	# [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009c3ff] usable
	# [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000db27bfff] usable
	# [    0.000000] BIOS-e820: [mem 0x00000000db282000-0x00000000db3ebfff] usable
	# [    0.000000] BIOS-e820: [mem 0x00000000db40f000-0x00000000db46efff] usable
	# [    0.000000] BIOS-e820: [mem 0x00000000db70f000-0x00000000db715fff] usable

	# Linux 3.0
	# "[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)"
	# "[    0.000000]  BIOS-e820: 0000000000100000 - 000000003f6d0000 (usable)"

	if thisline.find("mem") > -1 :
		# something with mem
		hexstuff = thisline.split()[4].rstrip(']')	# Now '0x00000000db71f000-0x00000000db77ffff'
		lower = int(hexstuff.split('-')[0] ,16)
		upper = int(hexstuff.split('-')[1] ,16)
	else :
		# no mem, old skool

		lower = int( (thisline.split()[3]) ,16) # pick element 3 (counting from 0), and convert to decimal
		upper = int( (thisline.split()[5]) ,16)

	biostotal += (upper-lower)/(1024*1024)


if not xen :
	print "BIOS offers", biostotal, "MB as usable"
else :
	print "Xen Virtual Machine offers", biostotal, "MB as usable"
	


# let's look what 'modified' tells us:

cmd = 'cat /var/log/dmesg | grep -i modified | grep -i usable'
biosmodifiedtotal = 0
for thisline in os.popen(cmd).readlines():
	
	'''
	[    0.000000]  modified: 0000000000000000 - 0000000000002000 (usable)
	[    0.000000]  modified: 0000000000006000 - 000000000009fc00 (usable)
	[    0.000000]  modified: 0000000000100000 - 0000000063bf0000 (usable)
	'''

	lower = int( (thisline.split()[3]) ,16) # pick element 3 (counting from 0), and convert to decimal
	upper = int( (thisline.split()[5]) ,16)
	biosmodifiedtotal += (upper-lower)/(1024*1024)
if biosmodifiedtotal > 0 :
	print "BIOS offers", biostotal, "MB as 'modified' usable"
	biostotal = biosmodifiedtotal
	
'''
sander@quirinius:~$ free -m | grep -i mem: 
Mem:           993        900         93          0         41        379
sander@quirinius:~$ 
'''

freetotal = int(os.popen('free -m | grep -i mem').readline().split()[1])
print "Memory seen by OS", freetotal, "MB"



'''
sander@quirinius:~$ sudo dmidecode -s bios-release-date
04/14/2009
sander@quirinius:~$ 
'''

if root:
	biosversion = os.popen('dmidecode -s bios-release-date').readline().strip()
	print "BIOS version", biosversion



if os.popen('grep -i pae /proc/cpuinfo').readlines() :
	cpupae = True
	print "CPU is PAE enabled"
else:
	cpupae = False
	print "CPU is not PAE enabled"


if os.popen('grep -i " lm " /proc/cpuinfo').readlines() :
	cpux86_64 = True
	print "CPU is x86_64 64-bit enabled"
else:
	cpux86_64 = False
	print "CPU is 32-bit, and not x86_64 enabled"




if os.popen('uname -a | grep -i "x86_64" ').readlines() :
	osx86_64 = True
	print "OS is x86_64 64-bit"
else:
	osx86_64 = False
	if os.popen('uname -r | grep -i pae').readlines() :
		ospae = True
		print "OS is 32-bit with PAE"
	else:
		ospae = False
		print "OS is 32-bit without PAE"






'''
Logical map - examples:

dimmtotal biostotal freetotal cpupae cpux86_64 osx86_64 ADVICE
3000		-	-	-	-	-	nothing needed
4000		3200					enable 'memory hole rempapping / hoisting' in your BIOS
4000		3800	3100	-	yes	no	use 64-bit OS
4000		3800	3100	yes	no	-	use PAE enabled OS
4000		3900	3800	-	-	-	nothing needed (!)		
6000		3900	3800				??????????? unknown problem
'''

'''
dimmtotal = 4012
biostotal = 3900
freetotal = 3100
'''

advicegiven = False;

print "\nSUMMARY:"
if not root:
	print "Attention: as you're not running this script as root, the summary below can contain strange numbers."

if dimmtotal> 0 :
	print "Memory difference between DIMM hardware and BIOS offering", dimmtotal-biostotal, "MB"

print "Memory difference between BIOS offering and memory seen by OS", biostotal-freetotal, "MB"

if dimmtotal> 0 :
	print "Memory difference between DIMM hardware and memory seen by OS", dimmtotal-freetotal, "MB"


if True:
	print "\nADVICE:"

	if dimmtotal<3200 :
		print "Your physical memory is less than 3200 MB, and your system does not need special memory treatment"
		advicegiven = True

	if dimmtotal>3200 and dimmtotal-biostotal>300 :
		print "Your BIOS is not offering all of your physical memory. Try to update your BIOS, and/or enable 'memory hole remapping / hoisting' in your BIOS to get more usable memory"
		advicegiven = True


	if biostotal>3600 and biostotal-freetotal>400:
		if cpux86_64 and not osx86_64 :
			print "You're running a 32-bit OS on a x86_64 CPU. Use a x86_84 64-bit OS to get access to more memory."
			if cpupae and not ospae :
				print "Or, probably easier: Upgrade to the 32-bit kernel 'linux-generic-pae' to get acces to more memory."
			advicegiven = True

		if not cpux86_64 and cpupae and not ospae:
			print "You're running a plain 32-bit OS on a 32-bit PAE-enabled CPU. Upgrade to the 32-bit kernel with PAE 'linux-generic-pae' to get access to more memory"
			advicegiven = True

	if not advicegiven :
		print "Nothing unusual found, so no advice for your setup"



if root:
	print "\nFinally: show more detailed memory info from lshw and dmidecode. This can take up to 30 seconds ..."
	print_output_from_cmd('lshw -class memory |  grep -i "\-memory" -A100 | grep -i -e capacity -e description -e size')
	print_output_from_cmd('dmidecode | grep -i -A3 -e "bios information" -e "system information"')
	print "\n"
	print_output_from_cmd('dmidecode | grep -i "Maximum Capacity"')
		
print "\nFinished"


'''
Some stuff from dmesg running in a VirtualBox Virtual Machine:

sander@sander-desktop:~$ dmesg | grep -i virtual
[    0.000000] CPU MTRRs all blank - virtualized system.
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] virtual kernel memory layout:
[    0.533128] input: Macintosh mouse button emulation as /devices/virtual/input/input2
sander@sander-desktop:~$ dmesg | grep -i vb
[    0.000000] ACPI: RSDP 000e0000 00024 (v02 VBOX  )
[    0.000000] ACPI: XSDT 63bf0030 0002C (v01 VBOX   VBOXXSDT 00000001 ASL  00000061)
[    0.000000] ACPI: FACP 63bf00e0 000F4 (v04 VBOX   VBOXFACP 00000001 ASL  00000061)
[    0.000000] ACPI: DSDT 63bf0220 01A0C (v01 VBOX   VBOXBIOS 00000002 INTL 20090521)
[    0.715837] ata1.00: ATA-6: VBOX HARDDISK, 1.0, max UDMA/133
[    0.821136] ata2.00: ATAPI: VBOX CD-ROM, 1.0, max UDMA/133
[    1.270253] scsi 0:0:0:0: Direct-Access     ATA      VBOX HARDDISK    1.0  PQ: 0 ANSI: 5
[    1.270910] scsi 1:0:0:0: CD-ROM            VBOX     CD-ROM           1.0  PQ: 0 ANSI: 5
sander@sander-desktop:~$ uname -a
Linux sander-desktop 2.6.32-16-generic #25-Ubuntu SMP Tue Mar 9 16:33:52 UTC 2010 i686 GNU/Linux
sander@sander-desktop:~$ 

'''


