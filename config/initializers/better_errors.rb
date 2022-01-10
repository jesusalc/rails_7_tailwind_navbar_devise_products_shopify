# frozen_string_literal: true

if defined?(BetterErrors)
  # BetterErrors.editor = "rubymine://open?file=%{file}:%{line}"
  BetterErrors.editor = "x-mine://open?file=%{file}:%{line}"
  #
  # e.g. in config/initializers/better_errors.rb
  # This will stop BetterErrors from trying to render larger objects, which can cause
  # slow loading times and browser performance problems. Stated size is in characters and refers
  # to the length of #inspect's payload for the given object. Please be aware that HTML escaping
  # modifies the size of this payload so setting this limit too precisely is not recommended.
  # default value: 100_000
  BetterErrors.maximum_variable_inspect_size = 100_000
  # e.g. in config/initializers/better_errors.rb
  # This will stop BetterErrors from trying to inspect objects of these classes, which can cause
  # slow loading times and unnecessary database queries. Does not check inheritance chain, use
  # strings not constants.
  # default value: ['ActionDispatch::Request', 'ActionDispatch::Response']
  BetterErrors.ignored_classes = ['ActionDispatch::Request', 'ActionDispatch::Response']
end
