require "lita"

module Lita
  module Handlers
    class Catfacts < Handler
      route %r{catfact(|s)}i, :catfacts, command: true, help: { "catfacts" => "Returns a random fact about cats." }

      def catfacts(response)
        resp = http.get('http://catfacts-api.appspot.com/api/facts?number=1')

        raise 'RequestFail' unless resp.status == 200
        
        obj = MultiJson.load(resp.body)

        raise 'ApiError' unless obj['success'] == "true"


        response.reply obj['facts'][0]

      rescue
        response.reply "Sorry, I was unable to find any cool facts about cats."
      end


    end

    Lita.register_handler(Catfacts)
  end
end
