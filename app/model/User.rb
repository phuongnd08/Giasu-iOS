class User
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns :id => :integer,
          :display_name => :string,
          :avatar_url => :string,
          :token => :string
end
