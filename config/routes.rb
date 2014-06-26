Sandbox::Application.routes.draw do
  root 'sandbox#index'

  controller :sandbox do
    get  'sandbox/about/:file' => :about, as: :sandbox_about
    get  'sandbox/echo_json' => :echo_json
    post 'sandbox/echo_json' => :echo_json
    get  'sandbox/echo_html' => :echo_html
    post 'sandbox/echo_html' => :echo_html
    get  'sandbox/chart/:type' => :get_chart
    get  'sandbox/poll_for_update' => :poll_for_update
    # see: http://stackoverflow.com/questions/5222760/rails-rest-routing-dots-in-the-resource-item-id
    get  'sandbox/:section/:dir/:file' => :show, as: :sandbox_dir_file, :constraints => { :file => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
    get  'sandbox/:section/:file' => :show, as: :sandbox_file, :constraints => { :file => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
    get  'sandbox/block/:section/:dir/:file/:index' => :embed_code, as: :sandbox_embed_code, :constraints => { :file => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
    get  'sandbox/codeblock_sizes/:section/:dir/:file/:index' => :codeblock_sizes, as: :sandbox_codeblock_sizes, :constraints => { :file => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
    get  'sandbox' => :index, as: :sandbox
  end

end
