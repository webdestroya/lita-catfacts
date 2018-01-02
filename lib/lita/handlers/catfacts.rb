require "lita"

module Lita
  module Handlers
    class Catfacts < Handler
      route %r{^catfact(|s)$}i, :catfacts, command: true, help: { "catfacts" => "Returns a random fact about cats." }

      def catfacts(response)
        resp = http.get('https://catfact.ninja/fact')

        raise 'RequestFail' unless resp.status == 200
        
        obj = MultiJson.load(resp.body)

        response.reply obj['fact']

      rescue
        response.reply "Sorry, I was unable to find any cool facts about cats."
      end


    end

    Lita.register_handler(Catfacts)
  end
end
