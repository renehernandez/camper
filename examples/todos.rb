require 'camp3'

Camp3.configure do |config|
  config.client_id = ENV['BASECAMP3_CLIENT_ID']
  config.client_secret = ENV['BASECAMP3_CLIENT_SECRET']
  config.account_number = ENV['BASECAMP3_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASECAMP3_REFRESH_TOKEN']
  config.access_token = ENV['BASECAMP3_ACCESS_TOKEN']
end

projects = Camp3.projects

projects.each do |p|
  puts "Project: #{p.inspect}"

  puts "Todo set: #{p.todoset.inspect}"

  todoset = Camp3.todoset(p)

  Camp3.todolists(todoset).each do |list|
    puts "Todolist: #{list.title}"

    Camp3.todos(list).each do |todo|
      puts todo.inspect
    end
  end
end