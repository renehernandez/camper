# frozen_string_literal: true

class Camper::Client
  # Defines methods related to people.
  # @see https://github.com/basecamp/bc3-api/blob/master/sections/people.md
  module PeopleAPI
    # Get all people visible to the current user
    #
    # @example
    #   client.people
    #
    # @return [Array<Resource>]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/people.md#get-all-people
    def people
      get('/people')
    end

    # Get all active people on the project with the given ID
    #
    # @example
    #   client.people_in_project(10)
    # @example
    #   client.people_in_project("20")
    # @example
    #   client.people_in_project(my_project)
    #
    # @param project [Resource|Integer|String] A project resource or a project id
    # @return [Array<Resource>]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/people.md#get-people-on-a-project
    def people_in_project(project)
      id = project.respond_to?(:id) ? project.id : project

      get("/projects/#{id}/people")
    end

    # Allows granting new and existing people access to a project, and revoking access from existing people.
    #
    # @example
    #   client.update_access_in_project(10, { grant: [102, 127] })
    # @example
    #   client.update_access_in_project("8634", { revoke: [300, 12527] })
    # @example
    #   client.update_access_in_project(my_project, {
    #     create: [{
    #       name: "Victor Copper",
    #       email_address: "victor@hanchodesign.com"
    #     }]
    #   })
    #
    # @param project [Resource|Integer|String] A project resource or a project id
    # @param options [Hash] options to update access, either grant, revoke or create new people
    # @return [Resource]
    # @raise [Error::InvalidParameter] if no option is specified
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/people.md#update-who-can-access-a-project
    def update_access_in_project(project, options = {})
      raise Camper::Error::InvalidParameter, 'options cannot be empty' if options.empty?

      id = project.respond_to?(:id) ? project.id : project

      put("/projects/#{id}/people/users", body: { **options })
    end

    # Get all people on this Basecamp account who can be pinged
    #
    # @example
    #   client.pingable_people
    #
    # @return [Array<Resource>]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/people.md#get-pingable-people
    def pingable_people
      get('/circles/people')
    end

    # Get the profile for the user with the given ID
    #
    # @example
    #   client.person(234790)
    #
    # @param id [Integer|String] A user id
    # @return [Resource]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/people.md#get-person
    def person(id)
      get("/people/#{id}")
    end

    # Get the current user's personal info.
    #
    # @example
    #   client.profile
    #
    # @return [Resource]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/people.md#get-my-personal-info
    def profile
      get('/my/profile')
    end
  end
end