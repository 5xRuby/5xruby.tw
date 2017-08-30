namespace :backup do
  desc "Basic task"
  task basic: :environment do
    suffix = [Settings.backup.basename, Time.now.strftime("%y-%m-%d-%H%M%S-%s")].join("-")
    dir4archive = File.join Settings.backup.tmp_dir, suffix
    pg_dump_cmd = Settings.backup.try(:pg_dump_cmd) || "pg_dump"
    dbconfigs = ActiveRecord::Base.configurations[Rails.env].symbolize_keys
    dst_file_path = File.join Settings.backup.dst_dir, suffix
    cmds = []
    FileUtils.mkdir_p dir4archive
    Dir.chdir dir4archive do
      ENV['PGUSER'] = dbconfigs.dig :username
      ENV['PGHOST'] = dbconfigs.dig :host
      ENV['PGPORT'] = dbconfigs.dig :port
      ENV['PGPASSWORD'] = dbconfigs.dig :password
      dbfn = "#{dbconfigs[:database]}-#{Time.now.to_i}.sql"
      cmds << "#{pg_dump_cmd} #{dbconfigs[:database]} -f #{dbfn}"
      cmds << "rm -rf #{File.join Rails.root, 'public/uploads/tmp/*'}"
      cmds << "mkdir -p uploads"
      cmds << "rsync -av #{File.join(Rails.root, "public/uploads/")} ./uploads/"
      cmds << "tar -jcvpf #{dst_file_path}.tar.bz2 *"
      cmds.each do |cmd|
        puts cmd
        system cmd
      end
    end
    Dir.chdir Settings.backup.dst_dir do
      files = Dir.glob('*.tar.bz2').sort_by do |f|
        File.ctime(f)
      end
      if files.size > Settings.backup.rotate_max_size
        files.shift(files.size - Settings.backup.rotate_max_size).each do |fn|
          puts "Delete file #{fn}"
          FileUtils.rm(fn)
        end
      end
    end
  end
end

