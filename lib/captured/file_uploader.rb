require 'digest/md5'

class FileUploader
  def self.upload(file)
    remote_name = Digest::MD5.hexdigest(file)
    puts "Uploading #{file}, remote name #{remote_name}!"
    system "scp '#{file}' 'fuzzymonk.com:fuzzymonk.com/captured/#{remote_name}.png'"
    `echo "http://fuzzymonk.com/captured/#{remote_name}.png" | pbcopy`
    `growlnotify -t "Captured" -m "Uploaded screenshot"`
  end
end
