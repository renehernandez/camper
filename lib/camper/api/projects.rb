# frozen_string_literal: true

class Camper::Client
  # Defines methods related to projects.
  # @see https://github.com/basecamp/bc3-api/blob/master/sections/projects.md
  module ProjectsAPI
    # Get the projects visible to the current user
    #
    # @example
    #   client.projects
    # @example
    #   client.projects(status: 'trashed')
    #
    # @param options [Hash] extra options to filter the list of todolist
    # @return [Array<Project>]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/projects.md#get-all-projects
    def projects(options = {})
      get('/projects', options)
    end

    # Get a project with a given id, granted they have access to it
    #
    # @example
    #   client.project(82564)
    # @example
    #   client.project('7364183')
    #
    # @param id [Integet|String] id of the project to retrieve
    # @return [Project]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/projects.md#get-a-project
    def project(id)
      get("/projects/#{id}")
    end

    # Create a project
    #
    # @example
    #   client.create_project("Marketing Campaign")
    # @example
    #   client.create_project('Better Marketing Campaign', "For Client: XYZ")
    #
    # @param name [String] name of the project to create
    # @param description [String] description of the project
    # @return [Project]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/projects.md#create-a-project
    def create_project(name, description = '')
      raise Camper::Error::InvalidParameter, name if name.blank?

      post('/projects', body: { name: name, description: description })
    end

    # Update a project
    #  description can be set to empty by passing an empty string
    #
    # @example
    #   client.update_project(12324, name: 'Retros')
    # @example
    #   client.update_project('157432', description: 'A new description')
    # @example
    #   client.update_project('157432', description: '')
    # @example
    #   client.update_project(my_project, name: 'A new name', description: 'A new description')
    #
    # @param project [Integer|String|Project] either a project object or a project id
    # @param name [String] optional new name of the project
    # @param description [String] optinal new description of the project
    # @return [Project]
    # @raise [Error::InvalidParameter] if both name and description are blank (nil or empty strings)
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/projects.md#update-a-project
    def update_project(project, name: '', description: nil)
      if name.blank? && description.blank?
        raise Camper::Error::InvalidParameter, 'name and description cannot both be blank'
      end

      id = project.respond_to?(:id) ? project.id : project

      options = {}
      options[:name] = name unless name.blank?
      options[:description] = description unless description.nil?

      put("/projects/#{id}", body: { **options })
    end

    # Delete a project
    #
    # @example
    #   client.delete_project(12324)
    # @example
    #   client.delete_project('157432')
    # @example
    #   client.delete_project(my_project)
    #
    # @param project [Integer|String|Project] either a project object or a project id
    # @raise [Error::InvalidParameter] if project param is blank
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/projects.md#trash-a-project
    def delete_project(project)
      if project.blank?
        raise Camper::Error::InvalidParameter, 'project cannot be blank'
      end

      id = project.respond_to?(:id) ? project.id : project

      delete("/projects/#{id}")
    end

    alias trash_project delete_project

    def message_board(project)
      board = project.message_board
      get(board.url, override_path: true)
    end

    def todoset(project)
      todoset = project.todoset
      get(todoset.url, override_path: true)
    end
  end
end