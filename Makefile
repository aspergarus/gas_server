all: build link
	strip gas_server

build:
	as -o gas_server.o -Os gas_server.s

link:
	ld -o gas_server -flto gas_server.o


