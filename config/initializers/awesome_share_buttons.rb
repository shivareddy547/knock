AwesomeShareButtons.configure do |config|
  # config.allow_sites = %w(twitter facebook google_plus delicious tumblr pinterest)
  config.allow_sites = %w(twitter facebook google_plus )

  AwesomeShareButtons::Helper.module_eval do
     def awesome_share_buttons(title = "", opts = {})
      extra_data = {}
      rel = opts[:rel]
      html = []
      # html << "<div class='awesome-share-buttons' data-title='#{h title}' data-img='#{opts[:image]}' data-url='#{opts[:url]}'>"

      AwesomeShareButtons.config.allow_sites.each do |name|
        extra_data = opts.select { |k, _| k.to_s.start_with?('data') } if name.eql?('tumblr')

        html << "<li>
            <img src='/assets/social/#{name}-circle.png' width='32' height='32'>
            <p>"

        # link_title = t "awesome_share_buttons.share_to", :name => t("awesome_share_buttons.#{name.downcase}")
        html << link_to("Share to #{name.downcase}","#", {:rel => ["nofollow", rel],:target=>"_blank",                                                                                         "data-site" => name,
                                                                                           :class => "awesome-share-buttons-#{name}",
                                                                                           :onclick => "return AwesomeShareButtons.share(this);",
                                                                                           :title => h("Share to #{name.downcase}")}.merge(extra_data))
      end
      html << "</p>
          </li>"
      raw html.join("\n")
    end

  end
end
