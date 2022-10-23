# frozen_string_literal: true

require 'sidekiq'


Sidekiq.configure_client do |config| 
    config.redis = { url: 'redis://localhost:6379/1' }
 end

Sidekiq.configure_server do |config| 
    config.redis = { url: 'redis://localhost:6379/1' }
 end

 class TestWorker 
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(complexity)
        case complexity 
        when "super_hard"
            puts "Charging a credit card..."
            raise "Credit card declined"
            sleep 20
            puts "Wow!, Worked super hard"
        when "hard"
            sleep 10
            puts "That Worked hard"
        else 
        sleep 5 
        puts "That Worked easy"
        end
    end 

    def perfom_later 
        TestWorker.perform_async
    end
 end 

