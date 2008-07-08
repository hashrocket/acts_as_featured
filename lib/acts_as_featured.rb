module Hashrocket #:nodoc:
  module Acts #:nodoc:
    # Allows ActiveRecord models to be specified as featured.
    #
    # Also provides named scopes for featured and unfeatured finds.
    #
    #   class Post  ActiveRecord::Base
    #     acts_as_featured
    #   end
    #
    #   Post.featured
    #   # SELECT * FROM posts WHERE posts.featured_at IS NOT NULL
    #
    #   Post.unfeatured
    #   # SELECT * FROM posts WHERE posts.featured_at IS NULL
    #
    #   @post.feature!
    #   # UPDATE posts SET featured_at = '2008-07-08 15:58:34' WHERE id = 1
    #
    #   @post.unfeature!
    #   # UPDATE posts SET featured_at = NULL WHERE id = 1
    #
    #   @post.featured?
    #   # Return true if the post is featured, false if not
    #
    module Featured
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_featured
          include InstanceMethods
        end
      end

      module InstanceMethods
        def self.included(base)
          base.named_scope :featured, :conditions => "#{base.table_name}.featured_at IS NOT NULL"
          base.named_scope :unfeatured, :conditions => "#{base.table_name}.featured_at IS NULL"
        end

        def feature!
          update_attribute :featured_at, Time.now
        end
        def unfeature!
          update_attribute :featured_at, nil
        end

        def featured?
          if featured_at
            true
          else
            false
          end
        end
      end
    end
  end
end
