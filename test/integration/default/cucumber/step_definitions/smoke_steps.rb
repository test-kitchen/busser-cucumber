# Loaded because the runner passes the suite directory to cucumber with
# --require. Without that, every step here comes back undefined.
Given("the machine under test is reachable") do
  @reached = true
end

Then("cucumber reports success") do
  raise "step definitions were not loaded" unless @reached
end
