Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemoryStore
Rack::MiniProfiler.config.skip_paths += %w[/img /js /css /uploads /sliderimages /rs-plugin /fontello /sponsors]