module TweetsHelper
    def hashtag(content)
        format_content = content.split(" ")
        tag = []
        format_content.each do |c|
            if c.start_with?("#")
                c = link_to c, controller: "tweets", q: c
            end
            tag << c
        end
        raw tag.join(" ")
    end
    
end
