local db_functions = {}
local mysql = require "resty.mysql"
local db,err
local user_id
local che_port

function db_functions.new(id)
	
	db, err = mysql:new()
	user_id = id -- Grabs the user name from the URL
	che_port = 8090	

	if not db then
        ngx.say("failed to instantiate mysql: ", err)
       	return
    end

    db:set_timeout(1000) -- 1 sec

    local ok, err, errcode, sqlstate = db:connect
    {
       	host = "127.0.0.1",
        port = 3306,
        database = "nginx",
       	user = "root",
        password = "root",
        max_packet_size = 1024 * 1024 
    }

    if not ok then
        ngx.log(ngx.ERR,"failed to connect: ", err, ": ", errcode, " ", sqlstate)
        return
    end
    ngx.say("conectou")
end

--Kind of incomplete. The idea was to remove the lua code from che.conf file, but doing that makes us build a wrapper module.
--which would abstract the operations on the database using lua, but that takes a lot of time to do. So lets see what is going to happen.
function db_functions.insert(table,collumn,value)
	res, err, errcode, sqlstate = db:query("insert into "..table.." ("..collumn..") values (\'" ..value.. "\')")
	ngx.say(res)
	if not res then
    	ngx.log(ngx.ERR,"Error inserting the new user: ", err, ": ", errcode, ":",sqlstate, ".")
       	return "Error"
 	end
end

function db_functions.search(table,collumn,comparison_collumn,value)
	res, err, errcode, sqlstate = db:query("select "..collumn.." from "..table.." where "..comparison_collumn"=\'" ..value.."\'")
    if not res then
   		ngx.log(ng.ERR,"Error on query for container matching the id on the url: ", err, ": ", errcode, ": ", sqlstate, ".")
       	return "Error"
    end
end

function db_functions.query()
end

return db_functions