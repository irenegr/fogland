#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import sys, imaplib

port = 993
server = 'imap.gmail.com'

username = 'YOUR_USERNSME'
passwd = 'YOUR_PASSWORD'

imap_server = imaplib.IMAP4_SSL(server, port)
try:
	imap_server.login(username, passwd)
except:
	print('?? new')
	sys.exit( 1 )

typ, data = imap_server.select ('Inbox', True)
if typ == 'OK':
	total = int(data[0])
	typ, data = imap_server.search (None, 'SEEN')
	if typ == 'OK':
		seen = len(data[0].split())
		print('{}/{}'.format(total, total - seen))

if typ != 'OK':
	print('?? new')

imap_server.logout()
