module ApplicationHelper
  def custom_noty_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>new Noty({ type: '#{type}', timeout: 4000, theme: 'mint', progressBar: true, text: '#{message}' }).show();</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

end
