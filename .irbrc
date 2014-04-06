begin
  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

begin
  require 'hirb'
  Hirb.enable
rescue LoadError => err
  warn "Couldn't load Hirb: #{err}"
end


if defined? Rails
  logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger = logger
  ActiveResource::Base.logger = logger
end


#http://stackoverflow.com/questions/123494/whats-your-favourite-irb-trick
#class Object
  ## Return only the methods not present on basic objects
  #def _interesting_methods
    #(self.methods - Object.new.methods).sort
  #end
#end
