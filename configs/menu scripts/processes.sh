#!/usr/bin/python
# -*- coding: utf-8 -*-
################################################################################
##
##    This script pipes a process manipulation menu into the openbox menu.
################################################################################
##    by Vlad George under GPLv2
##
## Usage:
##    Just place this script in ~/.config/openbox/scripts, make it executable, if you want you can enlist the processes 
##    which should not be shown in the unwanted_procs list below, then add following to your ~/.config/openbox/menu.xml:
##    "<menu id="proc-menu" label="processes" execute="~/.config/openbox/scripts/processes.py" />...
##    <menu id="root-menu" label="Openbox3">...<menu id="proc-menu" />...</menu>"
##    and reconfigure openbox.
##
################################################################################
##    processes (e.g. daemons, bash, this script, etc) you do not want to be shown in the process manipulation menu:
##    !!! don´t forget quotes !!!
##
##unwanted_procs=["processes.py","openbox","bash","ssh-agent","gconfd-2","gnome-pty-helpe","dbus-daemon","dbus-launch","kded","dcopserver","..."]
unwanted_procs=["processes.py"]

################################################################################
################################################################################

import os
import sys

##  pid -> processname
def procName(pid):
    return file(os.path.join('/proc', str(pid), 'status'), 'r').readline().split()[1]


##  pid -> info_list=[State, SleepAVG, VmSize, VmLck, VmRSS, VmLib, priority(nice), command]:
def procData(pid):
    info_list=[]
##  from /proc/<pid>/status get State, SleepAVG, VmSize, VmLck, VmRSS, VmLib
    status_file=file(os.path.join("/proc", str(pid), "status"), 'r')
    status=status_file.readlines()
    status_file.close()
    [info_list.append(status[i].split(":")[1].lstrip().rstrip("\n")) for i in (1,2,12,13,15,19)]
##  from /proc/<pid>/stat get priority(nicelevel)
    priority_file=file(os.path.join('/proc', str(pid), 'stat'), 'r')
    priority=priority_file.read()
    priority_file.close()
    info_list.append(priority.split()[18])
##  from /proc/<pid>/cmdline get command
    cmdline_file=file(os.path.join("/proc", str(pid),"cmdline"),'r')
    cmdline=cmdline_file.read()
    cmdline_file.close()
    info_list.append(" ".join(cmdline.split("\x00")[:-1]))
    return info_list


##  fiters pids from /proc/<pid>/ for user who owns script excluding the unwanted_procs ids:
def userPidFilter():
    uid=os.stat(sys.argv[0])[4]
    uid_pids = []
    for pid in os.listdir("/proc"):
        if os.path.isdir(os.path.join("/proc", pid)):
            try:
                if os.stat(os.path.join("/proc", pid))[4] == uid :
                    uid_pids.append(int(pid))
            except ValueError:
                pass

    proc_name = []
    [proc_name.append(procName(pid)) for pid in uid_pids]

    tmp=zip(proc_name, uid_pids)
    def removePidsFromList(i):
        if proc in tmp[i][0]:
            try:
                uid_pids.remove(tmp[i][1])
            except ValueError:
                pass
    for proc in unwanted_procs:
        map(removePidsFromList, xrange(len(tmp)))

    return uid_pids


##  xml output for each pid:                   
def printXml(pid):
##  procData(pid)=[[0]-State, [1]-SleepAVG, [2]-VmSize, [3]-VmLck, [4]-VmRSS, [5]-VmLib, [6]-priority(nice), [7]-command]:

    print '<item label="SleepAvg: %s"><action name="Execute"><execute>true</execute></action></item>' % (procData(pid)[1])
    print '<menu id="%s-menu-memory" label="memory (%s MB)">' % (pid, int(procData(pid)[2].split()[0])/1024)
    print '<item label="Ram: %s"><action name="Execute"><execute>true</execute></action></item>' % (procData(pid)[4])
    print '<item label="Lib: %s"><action name="Execute"><execute>true</execute></action></item>' % (procData(pid)[5])
    print '<item label="Lock: %s"><action name="Execute"><execute>true</execute></action></item>' % (procData(pid)[3])
    print '<item label="Total: %s"><action name="Execute"><execute>true</execute></action></item>' % (procData(pid)[2])
    print '</menu>'

    print '<separator />'

    print '<menu id="%s-menu-priority" label="priority (%s)">' % (pid, procData(pid)[6])
    print '<item label="-10 (fast)"><action name="Execute"><execute>renice -10 %s</execute></action></item>' % (pid)
    print '<item label="-5"><action name="Execute"><execute>renice -5 %s</execute></action></item>' % (pid)
    print '<item label="0 (base)"><action name="Execute"><execute>renice 0 %s</execute></action></item>' % (pid)
    print '<item label="5"><action name="Execute"><execute>renice 5 %s</execute></action></item>' % (pid)
    print '<item label="10"><action name="Execute"><execute>renice 10 %s</execute></action></item>' % (pid)
    print '<item label="15"><action name="Execute"><execute>renice 15 %s</execute></action></item>' % (pid)
    print '<item label="20 (idle)"><action name="Execute"><execute>renice 20 %s</execute></action></item>' % (pid)
    print '</menu>'

    print '<menu id="%s-menu-state" label="%s">' % (pid, procData(pid)[0])
    print '<item label="stop"><action name="Execute"><execute>kill -SIGSTOP %s</execute></action></item>' % (pid)
    print '<item label="continue"><action name="Execute"><execute>kill -SIGCONT %s</execute></action></item>' % (pid)
    print '</menu>'

    print '<menu id="%s-menu-stop" label="stop signals">' % (pid)
    print '<item label="exit"><action name="Execute"><execute>kill -TERM %s</execute></action></item>' % (pid)
    print '<item label="hangup"><action name="Execute"><execute>kill -HUP %s</execute></action></item>' % (pid)
    print '<item label="interrupt"><action name="Execute"><execute>kill -INT %s</execute></action></item>' % (pid)
    print '<item label="kill"><action name="Execute"><execute>kill -KILL %s</execute></action></item>' % (pid)
    print '</menu>'
    print '<separator />'
##    print '<item label="restart"><action name="Execute"><execute>kill %s &amp;&amp; %s </execute></action></item>' % (pid, procData(pid)[7])
    print '<item label="spawn new"><action name="Execute"><execute>%s</execute></action></item>' % (procData(pid)[7])


##  generate main menu:
def generateMenu(pid):
       print '<menu id="%s-menu" label="%s" execute="%s --pid %s"/>' % (pid, procName(pid), sys.argv[0], pid)


##  putting it all together:
print '<?xml version="1.0" encoding="UTF-8"?>'
print '<openbox_pipe_menu>'
args = sys.argv[1:]
if ('--pid' in args):
    printXml(int(sys.argv[2]))
else:
    map(generateMenu, userPidFilter())
print '</openbox_pipe_menu>'