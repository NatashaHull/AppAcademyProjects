module UrlHelper
  def create_simple_url_helpers(root_url="localhost:8080", path)
    #I am assuming there are not router params for the sake
    #of simplicity
    helper_name = path.split('/').join('_')
    define_method("#{helper_name}_url") do
      url = root_url
      url += path
      url
    end

    define_method("#{helper_name}_path") do
      path
    end
  end
end