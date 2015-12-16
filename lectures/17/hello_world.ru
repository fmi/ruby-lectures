hello_world_app = proc do |env|
  [200, {'Content-Type'   => 'text/plain'}, ['Hello, World!']]
end

use Rack::Runtime
run hello_world_app
