module Sessions
  class SignIn < Trailblazer::Operation
    step :run

    def run(ctx, params:, **)
      ctx[:model] = User.find_by username: 'gokhan'
    end
  end
end