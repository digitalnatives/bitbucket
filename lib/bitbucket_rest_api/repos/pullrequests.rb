# encoding: utf-8

module BitBucket
  class Repos::PullRequests < API

    # List pull requests on a repository
    #
    # = Parameters
    # * <tt>:state</tt> Optional string. A string representing the state of the pull request: DECLINED, OPEN, MERGED
    #
    # = Examples
    #  bitbucket = BitBucket.new
    #  bitbucket.repos.pullrequests.list 'user-name', 'repo-name', :state => '...'
    #
    def list(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params
      filter! %w[ state], params

      response = get_request("/repositories/#{user}/#{repo.downcase}/pullrequests", params, get_v2_options)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :all :list

    # Gets a single pull request
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.pullrequests.get 'user-name', 'repo-name', '6dcb09b5b57875f334f61aebed6'
    #
    def get(user_name, repo_name, sha, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of sha
      normalize! params

      get_request("/repositories/#{user}/#{repo.downcase}/pullrequests/#{sha}", params, get_v2_options)
    end
    alias :find :get

    # Gets the activity for the repo's pull requests
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.pullrequests.activity 'user-name', 'repo-name'
    #
    def activity(user_name, repo_name, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      normalize! params

      get_request("/repositories/#{user}/#{repo.downcase}/pullrequests/activity", params, get_v2_options)
    end

    # Approve a pull request on a repository
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.pullrequests.approve 'user-name', 'repo-name', 123
    #
    def approve(user_name, repo_name, pr_id, params = {})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of pr_id
      normalize! params

      post_request("/repositories/#{user}/#{repo.downcase}/pullrequests/#{pr_id}/approve", params, get_v2_options)
    end

    # Unapprove a pull request on a repository
    #
    # = Examples
    #  @bitbucket = BitBucket.new
    #  @bitbucket.repos.pullrequests.unapprove 'user-name', 'repo-name', 123
    #
    def unapprove(user_name, repo_name, pr_id, params = {})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _validate_presence_of pr_id
      normalize! params

      delete_request("/repositories/#{user}/#{repo.downcase}/pullrequests/#{pr_id}/approve", params, get_v2_options)
    end

    private

    def get_v2_options
      {:url => BitBucket.endpoint.gsub(/1.0/, '2.0')}
    end

  end # Repos::Commits
end # BitBucket
