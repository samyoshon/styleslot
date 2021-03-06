class UsersController < ApplicationController




    def index
        @q = User.ransack(params[:q])

        @users = @q.result.paginate(page: params[:page], per_page: 30).where(["updated_at > ?", 360.days.ago]).order("updated_at DESC")

        ## Find Countries That Have Job Posts - Used for filter option
        @resumes = User.where(["updated_at > ?", 360.days.ago]).order("created_at DESC")

        @top_countries = []
        @resumes.each do |resume|
            if resume.countrya?
                @top_countries << resume.countrya
            end
            if resume.countryb?
                @top_countries << resume.countryb
            end
            if resume.countryc?
                @top_countries << resume.countryc
            end
        end
        @top_countries_uniq = @top_countries.uniq.sort!{|x,y| x <=> y }
        # .sort_by!{|e| e.downcase}
    end

    def show
        @user = User.find(params[:id])

        @date = Date.today
    end

private 
    def resume_params
        params.require(:resume).permit(:name, :first_name, :email, :lastname, :citizenship)
    end


end