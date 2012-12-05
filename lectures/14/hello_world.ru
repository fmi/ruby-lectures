hello_world_app = proc do |env|
  [200, {'Content-Type'   => 'text/plain'}, ['Hello, World!']]
end

run hello_world_app
