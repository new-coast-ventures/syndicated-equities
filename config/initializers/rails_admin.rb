RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do
    unless current_user.admin?
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end

  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar false

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    become_user   # Add the clone action

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Form' do
    list do
      field :owner
      field :title
      field :document
    end

    edit do
      field :owner
      field :title
      field :document
    end
  end

  config.model 'User' do
    list do
      field :first_name
      field :last_name
      field :address
      field :email
      field :created_at
      field :updated_at
    end

    edit do
      field :first_name
      field :last_name
      field :approved
      field :address
      field :email
      field :password
      field :admin
      field :employee
      field :viewer
      field :investments do
        searchable [:investor_first_name, :investor_last_name, :investing_entity]
      end
    end
  end

  config.model 'Investment' do
    list do
      field :investing_entity
      field :investor
      field :deal
      field :amount
      field :investor_first_name
      field :investor_last_name
    end

    edit do
      field :investor
      field :deal
      field :amount
      field :investing_entity
      field :investor_first_name
      field :investor_last_name
    end

    object_label_method do 
      :custom_investment_label
    end
  end

  config.model 'Deal' do
    edit do
      field :title
      field :description
      field :date
    end
  end

  config.model 'Note' do
    list do
      configure :content do
        hide
      end
    end

    show do
      configure :content do
        pretty_value do
          value.html_safe
        end
      end
    end

    edit do
      configure :content do
        partial "redactor"
      end
    end
  end

  def custom_investment_label
    "#{self.investor_first_name} #{self.investor_last_name} | #{self.deal.title}"
  end
end
