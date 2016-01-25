Hospital Bed Management System  
---  
### Current TEST server  
url: `bed.mhaii.xyz`  
login: [<< your machine's username >>] + [deploy]  
password: `none`, only `passphrase` login allowed  
---  
## Main components  
* `Python 3.x`  
* Node Package Manager, `npm`  
* `MySQL` Server  
  
#### For OSX  
+ `Homebrew`  
```  
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```  
  
#### For deploying to server capability  
+ `Capistrano`  
```  
gem install Capistrano  
```  
<< in Project directory: do >>  
```  
cap deploy  
```  
---  
  
### Provided 'Scripts' Functions  
+ `collect_static.py`  
  runs `manage.py collectstatic` with addition arguments that will excludes source files.  
  Eg. `*.sass`, `*.coffee`  
+ `create_app.py`  
  runs `manage.py startapp` with input() as new application name  
+ `fabric.py` *might be removed soon*  
  script file for installing `Fabric`, with `Python2` checking  
+ `flush_db.py`  
  runs `manage.py flush --no-input`, cleansing default database  
+ `i18n.py`  
  **This does not automatically generate new local directory for you**  
  runs `manage.py makemessages` to fetch all the translating texts into `*.po` file.  
  then `manage.py compilemessages` to compile `*.po` file into a callable format.  
+ `import_fixture.py`  
  walks through all the apps directory and will try to run `manage.py loaddata` on  
  `json` or `yaml` file that it found in `fixture` directory  
+ `init.py` *depends on running OS*  
  runs `apt-get` or `brew` to install system dependencies  
  
  Current system dependencies: [`MySQL`, `npm`, `gettext`, `msgpack`]  
+ `install_requirement.py`  
  installs required `Python` packages based on `requirement.txt`  
+ `make_and_migrate.py` *will be removed as soon as the project is actually use*  
  runs `manage.py makemigrations`  
  then `manage.py migrate`  
+ `module.py`  
  install `Javascript` dependencies, [`angular`, `bower`, `coffee`]  
  then run `manage.py bower install` to import required static files
  
### Order of script from scratch
1. `init.py`
2. `module.py`
3. `install_requirement.py`
4. `make_and_migrate.py`
5. `import_fixture.py`
6. `i18n.py`