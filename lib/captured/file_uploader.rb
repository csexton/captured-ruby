require 'digest/md5'

class FileUploader
  def self.upload(file)
    remote_name = Digest::MD5.hexdigest(file)
    puts "Uploading #{file}, remote name #{remote_name}!"
    if system "scp '#{file}' 'fuzzymonk.com:fuzzymonk.com/captured/#{remote_name}.png'"
      `echo "http://fuzzymonk.com/captured/#{remote_name}.png" | pbcopy`
      `growlnotify -t "Captured" -m "Uploaded screenshot" --image "#{File.dirname(File.expand_path(__FILE__))}/../../resources/captured.png"`
    else
      `growlnotify -t "Captured" -m "Uploaded failed." --image "#{File.dirname(File.expand_path(__FILE__))}/../../resources/red_x.png"`
    end
  end
end
