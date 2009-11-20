# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  require 'rubygems'
  require 'rdiscount'



  def textilize(text)
    #RedCloth.new(text.gsub(/</, '&lt;').gsub(/>/, '&gt;')).to_html
		RedCloth.new(text).to_html
  end


  def prettify(text, options = {})

		# Image Link
		newtext = ""
		text.each do |line|
			if line.length != 0
				image_start = line.index("$i$")
				image_end = line.index("$$")
				image_string = ""
				image_string_new = ""
				image_parts = ""
				if image_end != nil
					image_string = line[(image_start+3)..(image_end-1)]
					image_parts = image_string.split("|")
					image_string = "$i$" << image_string << "$$"
					image_string_new = '<center><a href="' << image_parts[1] << '" alt="' << image_parts[0] << '" title="' << image_parts[0] << '" rel="lightbox[post]"><img src="' << image_parts[1] << '" width="300px" height="250px"></a><div class="preview_enlarge">[Click to Enlarge]</div></center><div style="height:20px;"></div>'
					#line << "\n line[#{(image_start+3)}..#{(image_end-1)}]\n" << image_string
					line = line.gsub(image_string,image_string_new)
				end
			end
			newtext << line
		end
		text = newtext

		# Syntax Hignlighting
		text = text.gsub("@-code-@", "<code lang=\"ruby\">")
		text = text.gsub("@@", "</code>")
    text_pieces = text.split(/(<code>|<code lang="[A-Za-z0-9_-]+">|<code lang='[A-Za-z0-9_-]+'>|<\/code>)/)
    in_pre = false
    language = nil
    text_pieces.collect do |piece|
      if piece =~ /^<code( lang=(["'])?(.*)\2)?>$/
        language = $3
        in_pre = true
        nil
      elsif piece == "</code>"
        in_pre = false
        language = nil
        nil
      elsif in_pre
        lang = language ? language : "ruby"
        code(piece.strip, :lang => lang)
      else
        markdown(piece, options)
      end

    end
  end
  

  def markdown(text, options = {})
    if options[:strip]
      #RDiscount.new(strip_tags(text.strip)).to_html
			textilize(strip_tags(text.strip))
    else
      #RDiscount.new(text.strip).to_html
			textilize(text.strip)
    end
  end


	def preview(text)
		#tmptext = prettify(text)
		newtext = ""
		linecount = 0
		text.each do |line|
			if linecount < 15
					if line.length != 0
						newtext << line
						linecount += 1
					else
						newtext << line
					end
			end
		end
		newtext << "</code><center><b>...</b></center>"
		prettify(newtext)
	end


	def taglinks(text)
		if text != nil
			# Split the tags and insert links
			@tagsplit = text.split(',')
			tagshort = ''
			@tagsplit.each do |tag|
				tagshort = tagshort == "" ? '<a href="/tags/' << tag << '">' <<tag << '</a>' : tagshort << ', <a href="/tags/' << tag << '">' <<tag << '</a>'
			end
			'<div class="tags">TAGS: '+tagshort+'</div>'
		end
	end


	def taglinkssidebar(text)
		if text != nil
			# Split the tags and insert links
			@tagsplit = text.split(',')
			tagshort = ''
			@tagsplit.each do |tag|
				tagshort = tagshort == "" ? '<a href="/tags/' << tag << '">' <<tag << '</a>' : tagshort << ' <a href="/tags/' << tag << '">' <<tag << '</a>'
			end
			'<div class="tags-sidebar">'+tagshort+'</div>'
		end
	end


	def taglinksarchieves(text)
		if text != nil
			# Split the tags and insert links
			@tagsplit = text.split(',')
			tagshort = ''
			@tagsplit.each do |tag|
				tagshort = tagshort == "" ? '<a href="/tags/' << tag << '">' <<tag << '</a>' : tagshort << ', <a href="/tags/' << tag << '">' <<tag << '</a>'
			end
			'<div class="tags">'+tagshort+'</div>'
		end
	end


	def tag_cloud(tags, classes)
	  max, min = 0, 0
	  tags.each do |t|
	    max = t[1].to_i if t[1].to_i > max
	    min = t[1].to_i if t[1].to_i < min
	  end
	  divisor = ((max - min) / classes.size) + 1
	  tags.each do |t|
	    yield t[0], classes[(t[1].to_i - min) / divisor], t[1]
	  end
	end


  # Gets the thumbnail name for a filename.  'foo.jpg' becomes 'foo_thumbnail.jpg'
  def get_file_extension(filename = nil)
    return "unknown" if filename.blank?
    	ext = nil
	    basename = filename.gsub /\.\w+$/ do |s|
	      ext = s; ''
	    end
    	"#{ext.slice(1..(ext.length-1)).downcase}"
    end





	def get_username(user_id)
	  @user = User.find_by_id(user_id)
		return @user.login
  end

	def get_usergroup(usergroup_id)
	  @usergroup = User.find_by_id(usergroup_id)
		return @usergroup.name
  end




	# BLOG COUNTS
	
	def get_post_count()
		Post.count()
	end

	def get_file_count()
		Download.count(:conditions => {:parent_id => nil})
	end

	def get_comment_count()
		Comment.count()
	end



	# USER COUNTS

	def get_user_post_count(user_id)
		Post.count(:conditions => "user_id = '#{user_id}'")
	end

	def get_user_file_count(user_id)
		Download.count(:conditions => {:user_id => user_id, :parent_id => nil})
	end

	def get_user_comment_count(user_id)
		Comment.count(:conditions => "user_id = '#{user_id}'")
	end


	# USER COUNT PERCENT

	def get_user_post_percent(user_id)
		( ( Post.count(:conditions => "user_id = '#{user_id}'") / Post.count() ) * 100 ).to_s + '%'
	end

	def get_user_file_percent(user_id)
		( ( Download.count(:conditions => {:user_id => user_id, :parent_id => nil}) / Download.count(:conditions => {:parent_id => nil}) ) * 100 ).to_s + '%'
	end

	def get_user_comment_percent(user_id)
		( ( Comment.count(:conditions => "user_id = '#{user_id}'") / Comment.count() ) * 100 ).to_s + '%'
	end

	def get_user_percent(user_id)
		total_all = Post.count() + Download.count(:conditions => {:parent_id => nil}) + Comment.count()
		total_user = Post.count(:conditions => "user_id = '#{user_id}'") + Download.count(:conditions => {:user_id => user_id, :parent_id => nil}) + Comment.count(:conditions => "user_id = '#{user_id}'")
		( ( total_user / total_all ) * 100 ).to_s + '%'
	end

end
