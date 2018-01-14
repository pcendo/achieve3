module InstagramsHelper
    def choose_new_or_edit
        if action_name == 'new' || action_name == 'confirm'
            confirm_instagrams_path
        elsif action_name == 'edit'
            instagram_path
        end
    end
end
