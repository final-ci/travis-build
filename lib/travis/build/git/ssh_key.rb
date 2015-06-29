module Travis
  module Build
    class Git
      class SshKey < Struct.new(:sh, :data)
        def apply
          sh.newline
          sh.echo messages
          sh.newline

          sh.file '~/.ssh/id_rsa', key.value
          sh.chmod 600, '~/.ssh/id_rsa', echo: false
          sh.raw 'eval `ssh-agent` &> /dev/null'
          sh.raw 'ssh-add ~/.ssh/id_rsa &> /dev/null'
        end

        private

          def key
            data.ssh_key
          end

          def messages
            msgs = ["Installing an SSH key#{" from: #{source}" if key.source}"]
            msgs << "Key fingerprint: #{key.fingerprint}" if key.fingerprint
            msgs
          end

          def source
            key.source.gsub(/[_-]+/, ' ')
          end
      end
    end
  end
end
