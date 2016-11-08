RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.admin?
  end

  ## == Cancan ==
  # config.authorize_with :cancan

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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
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
      field :address
      field :email
      field :password
      field :admin
    end
  end

  config.model 'Investment' do
    configure :amount_invested do
      formatted_value do
        bindings[:view].number_to_currency(value.to_s, precision: 0)
      end

      pretty_value do
        bindings[:view].number_to_currency(value.to_s, precision: 0)
      end
    end
  end

  config.model 'Deal' do
    edit do
      field :title
      field :description
    end
  end
end
