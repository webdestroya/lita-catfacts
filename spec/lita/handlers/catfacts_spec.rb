require "spec_helper"

describe Lita::Handlers::Catfacts, lita_handler: true do
  it { routes_command("catfacts").to(:catfacts) }
  it { routes_command("catfact").to(:catfacts) }
end
