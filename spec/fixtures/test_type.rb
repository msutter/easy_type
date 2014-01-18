module Puppet

  newtype(:test) do
  	include EasyType

    to_get_raw_resources do
    	[
    		{:name => 'my_first_name'	, :my_property => 'my first property'},
    		{:name => 'my_second_name', :my_property => 'my second property'}
    	]
    end

    ensurable

		set_command(:do_command)

    on_create do
    	"on_create"
    end

    on_modify do
    	"on_modify"
    end

    on_destroy do
    	"on_destroy"
    end

    newparam(:name) do
	  	include EasyType
      include EasyType::Validators::Name

      isnamevar

      to_translate_to_resource do | raw_resource|
      	raw_resource[:name]
      end

      on_apply do
      	"name attribute applied"
      end

    end

    newproperty(:my_property) do
	  	include EasyType

      to_translate_to_resource do | raw_resource|
      	raw_resource[:my_property]
      end

      on_apply do |builder| 
      	"my_property applied"
      end

    end

  	provide(:simple) do
  		include EasyType::Provider
		  mk_resource_methods

			def do_command(line, options)
				"do command #{line}"
			end
  	end



  end
end

