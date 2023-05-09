class BookmarksController < ApplicationController

  def index

    user_id = session.fetch(:user_id)
    @current_username = User.where({ :id => user_id })[0]
    @bookmarks = Bookmark.where({ :user_id => user_id })

    render({ :template => "bookmarks/index.html.erb" })

  end

  def create

    #  id         :integer          not null, primary key
    #  created_at :datetime         not null
    #  updated_at :datetime         not null
    #  movie_id   :integer
    #  user_id    :integer

    movie_id = params.fetch("movie_id")
    user_id = session.fetch(:user_id)

    new_bookmark = Bookmark.new
    new_bookmark.movie_id = movie_id
    new_bookmark.user_id = user_id

    if new_bookmark.valid?
      new_bookmark.save
      redirect_to("/bookmarks", { :notice => "Bookmark created successfully." })
    else
      redirect_to("/movies/#{movie_id}", { :alert => new_bookmark.errors.full_messages.to_sentence })
    end


  end

end
