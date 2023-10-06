all: build

APP_GIT		:= cpu_consume
APP          := cpu_consume
LD_FLAGS     := "-s -w "

linux-amd64:
	@ CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags=$(LD_FLAGS) -o ./cmd/$(APP)/$(APP)-$@  ./cmd/$(APP)/

darwin-amd64:
	@ CGO_ENABLED=1 CC=clang  GOOS=darwin GOARCH=amd64 go build -buildmode=pie -ldflags=$(LD_FLAGS) -o ./cmd/$(APP)/$(APP)-$@  ./cmd/$(APP)/

windows:
	@CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc GOOS=windows GOARCH=amd64 go build -buildmode=pie -ldflags=$(LD_FLAGS) -o ./cmd/$(APP)/$(APP).exe ./cmd/$(APP)/
windows-amd64:
	@CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc GOOS=windows GOARCH=amd64 go build -buildmode=pie -ldflags=$(LD_FLAGS) -o ./cmd/$(APP)/$(APP)-$@  ./cmd/$(APP)/

build: linux-amd64 darwin-amd64 windows


run:
	@ LOG_DATE_TIME=1 DEBUG=1 RUN_MIGRATIONS=1 go run  ./cmd/$(APP)/


clean:
	@ rm -f db.kns $(APP)-* $(APP) $(APP)*.rpm $(APP)*.deb ./cmd/$(APP)/$(APP)*.exe ./cmd/$(APP)/$(APP)-* ./cmd/$(APP)/*.kns  ./cmd/$(APP)/$(APP)
	@ rm -rf ./conf ./log ./upload
	@ rm -rf ./cmd/$(APP)/conf ./cmd/$(APP)/log ./cmd/$(APP)/upload
	@ rm -rf ./cmd/$(APP)/*.lock

gitinit:
	git init
	git add .
	git commit -m "第一次提交"
	git remote add gitee git@gitee.com:lyhuilin/$(APP_GIT).git
	git remote add github git@github.com:clin003/$(APP_GIT).git
	#git push -u gitee main
	git push -u github main
	git tag "v0.0.1"
	#git push --tags  -u gitee main
	git push --tags  -u github main
	
gitpush:	
	#git push -u gitee main
	git push -u github main	
	#git push --tags  -u gitee main
	git push --tags  -u github main
		
