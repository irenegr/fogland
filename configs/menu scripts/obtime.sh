#!/bin/bash
DateTime=$(date '+Time: %H:%M ')
DateDate=$(date '+Date: %a %d/%m ')
echo "<openbox_pipe_menu>"
echo "<item label=\"$DateTime\"/>"
echo "<item label=\"$DateDate\"/>"
echo "</openbox_pipe_menu>"