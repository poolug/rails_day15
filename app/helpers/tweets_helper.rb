module TweetsHelper
    def hashtag(content)
        format_content = content.split(" ")
        tag = []
        format_content.each do |c|
            if c.start_with?("#")
                c = link_to c, controller: "tweets", twt: c
            end
            tag << c
        end
        raw tag.join(" ")
    end
    
end
