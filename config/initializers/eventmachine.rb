# Allow websocket to be use on event-base webserver other than `thin`
Thread.new { EventMachine.run } unless EventMachine.reactor_running? && EventMachine.reactor_thread.alive?