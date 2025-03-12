Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173' # 개발용은 '*' 모든 origin 허용. 배포 땐 도메인 제한!
    
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head], # 옵션 추가!
      credentials: true
  end
end
