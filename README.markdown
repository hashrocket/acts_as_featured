ActsAsFeatured
==============
Allows ActiveRecord models to be specified as featured by updating a `featured_at` datetime (or timestamp) field on the model.

Also provides named scopes for featured and unfeatured finds.

Requires Rails > 2.1.0

Installation
============

Add a `featured_at` datetime field to any model that you want to be featured.

Example
=======

    # Add the column
    ./script/generate migration AddFeaturedAtToPost featured_at:datetime
    rake db:migrate

    class Post < ActiveRecord::Base
      acts_as_featured
    end
    
    Post.featured
    # SELECT * FROM posts WHERE posts.featured_at IS NOT NULL
    
    Post.unfeatured
    # SELECT * FROM posts WHERE posts.featured_at IS NULL
    
    @post.feature!
    # UPDATE posts SET featured_at = '2008-07-08 15:58:34' WHERE id = 1
    
    @post.unfeature!
    # UPDATE posts SET featured_at = NULL WHERE id = 1
    
    @post.featured?
    # Return true if the post is featured, false if not

Copyright (c) 2008 Rein Henrichs, released under the MIT license
