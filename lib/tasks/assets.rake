Rake::Task['assets:precompile']
  .clear_prerequisites
  .enhance(['assets:compile_environment'])

namespace :assets do
  task compile_environment: :webpack do
    Rake::Task['assets:environment'].invoke
  end

  desc 'Compile assets with webpack'
  task :webpack do
    Dir.chdir Rails.root.join('frontend') do
      sh '$(npm bin)/gulp webpack'
    end
  end
end
