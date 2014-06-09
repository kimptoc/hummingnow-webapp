class ActiveSupport::Logger::SimpleFormatter
  def call(severity, time, progname, msg)

    level = {
      "DEBUG" => "DBG",
      "INFO" => "INF",
      "WARN" => "WRN",
      "ERROR" => "ERR",
      "FATAL" => "FTL"
    }[severity] || "???"

    @threads = {} unless @threads.present?

    threadName = @threads[Thread.current]
    unless threadName.present?
      @threads[Thread.current] = "THD"+ (@threads.size+1).to_s
      threadName = @threads[Thread.current]
    end

    "%s:%s:%s>%s\n" % [      time.strftime("%Y%m%d %H:%M:%S.%L") ,
                              level,
                              threadName,
                                   msg2str(msg)]

    #"[#{severity}] #{msg}\n"
  end
end

def msg2str(msg)
  case msg
  when ::String
    msg
  when ::Exception
    "#{ msg.message } (#{ msg.class })\n" <<
      (msg.backtrace || []).join("\n")
  else
    msg.inspect
  end
end

# module ActiveSupport
#   class BufferedLogger

#     #todo - make this work with rails 3.2
#     def addXXX(severity, message = nil, progname = nil, &block)
#       return if @level > severity
#       message = (message || (block && block.call) || progname).to_s

#       level = {
#         0 => "DBG",
#         1 => "INF",
#         2 => "WRN",
#         3 => "ERR",
#         4 => "FTL"
#       }[severity] || "???"

#       #@threads = {} unless @threads.present?
#       #
#       #threadName = @threads[Thread.current]
#       #unless threadName.present?
#       #  @threads[Thread.current] = "THD"+ (@threads.size+1).to_s
#       #  threadName = @threads[Thread.current]
#       #end

#       message = "%s:%s: %s>%s" % [Utils::ThreadHelper.name,
#                                        level,
#                                      Time.now.strftime("%H:%M:%S"),
#                                      message]

#       message = "#{message}\n" unless message[-1] == ?\n
#       buffer << message
#       auto_flush
#       message
#     end
#   end
# end
