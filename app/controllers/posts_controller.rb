# app/controllers/posts_controller.rb
class PostsController < ApplicationController

  def index
    @posts = Post.all.order( created_at: :desc )

    respond_to do |format|

      # Renders the usual `index.html.erb` template
      format.html

      # Send back a specific collection, so no template
      #   needed
      format.json { render json: @posts }

      # Renders the `index.js.erb` template by default
      format.js

    end
  end 


  def create
    @post = Post.new( post_params )

    if @post.save
      flash[:success] = "Post successfully created!"

      respond_to do |format|

        # Go back to the index page
        format.html { redirect_to posts_path }

        # Just render the object directly, no need
        #   to redirect
        format.json { render  json: @post, 
                              status: :created }

        # Just render a `create_success.js.erb` 
        #   template directly (no redirect)
        # This template will take care of inserting
        #   the new object into the dom
        format.js { render :create_success }

      end

    else # failed to create

      flash.now[:error] = "Post could not be created"

      respond_to do |format|

        # Render the `new.html.erb` template
        format.html { render :new }

        # Just render the object directly but with
        #   an error code, no need to redirect.
        # Note that the status code should change
        #   depending on the reason why it failed
        format.json { render nothing: true,
                             status: 400 } # Bad Request 

        # Re-render our New form using the 
        #   `new.js.erb` template
        format.js { render :new }

      end
    end

  end


  private
  def post_params
    params.require( :post ).permit( :title, :body )
  end

end