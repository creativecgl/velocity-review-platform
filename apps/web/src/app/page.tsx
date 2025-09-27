'use client'

import { useState } from 'react'
import { motion } from 'framer-motion'
import { Play, Upload, Users, Zap, CheckCircle, ArrowRight, Github, Star } from 'lucide-react'

export default function HomePage() {
  const [email, setEmail] = useState('')

  const handleGetStarted = () => {
    // This will redirect to the auth flow once implemented
    alert('Platform launching soon! We\'ll set up your account.')
  }

  return (
    <div className="min-h-screen bg-gray-900">
      {/* Header */}
      <header className="relative z-50 border-b border-gray-800">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <div className="flex items-center space-x-2">
              <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center">
                <Zap className="w-5 h-5 text-white" />
              </div>
              <span className="text-xl font-bold text-white">Velocity</span>
            </div>
            
            <div className="flex items-center space-x-6">
              <a href="#features" className="text-gray-300 hover:text-white transition-colors">
                Features
              </a>
              <a href="#how-it-works" className="text-gray-300 hover:text-white transition-colors">
                How it Works
              </a>
              <a href="https://github.com/creativecgl/velocity-review-platform" 
                 className="text-gray-300 hover:text-white transition-colors flex items-center space-x-1"
                 target="_blank" rel="noopener noreferrer">
                <Github className="w-4 h-4" />
                <span>GitHub</span>
              </a>
              <button 
                onClick={handleGetStarted}
                className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition-colors"
              >
                Get Started
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="relative pt-20 pb-32 overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-br from-blue-600/20 via-purple-600/20 to-pink-600/20" />
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
          >
            <h1 className="text-6xl lg:text-7xl font-bold text-white mb-8">
              <span className="bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent">
                Video Review
              </span>
              <br />
              <span className="text-white">Reimagined</span>
            </h1>
            
            <p className="text-xl text-gray-300 mb-12 max-w-3xl mx-auto leading-relaxed">
              Transform your video production workflow with seamless clip variation swapping, 
              real-time collaboration, and Apple-inspired UX. From days to hours.
            </p>
            
            <div className="flex items-center justify-center space-x-6">
              <motion.button
                onClick={handleGetStarted}
                className="bg-blue-600 hover:bg-blue-700 text-white px-8 py-4 rounded-xl font-semibold text-lg transition-all duration-200 flex items-center space-x-2"
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
              >
                <Play className="w-5 h-5" fill="white" />
                <span>Start Free Trial</span>
              </motion.button>
              
              <a href="#demo" className="text-gray-300 hover:text-white transition-colors flex items-center space-x-2">
                <span>Watch Demo</span>
                <ArrowRight className="w-4 h-4" />
              </a>
            </div>
          </motion.div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="py-20 bg-gray-800/50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-white mb-4">Built for Speed & Collaboration</h2>
            <p className="text-gray-400 text-lg max-w-2xl mx-auto">
              Every feature designed to eliminate friction in your video review workflow
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <motion.div
              className="bg-gray-800 p-8 rounded-2xl border border-gray-700"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6 }}
              viewport={{ once: true }}
            >
              <div className="w-12 h-12 bg-blue-600 rounded-lg flex items-center justify-center mb-6">
                <Zap className="w-6 h-6 text-white" />
              </div>
              <h3 className="text-xl font-semibold text-white mb-4">Seamless Transitions</h3>
              <p className="text-gray-400">
                < 100ms clip swapping with zero flicker using dual-buffer architecture. 
                Smooth as butter, fast as lightning.
              </p>
            </motion.div>
            
            <motion.div
              className="bg-gray-800 p-8 rounded-2xl border border-gray-700"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.1 }}
              viewport={{ once: true }}
            >
              <div className="w-12 h-12 bg-purple-600 rounded-lg flex items-center justify-center mb-6">
                <Upload className="w-6 h-6 text-white" />
              </div>
              <h3 className="text-xl font-semibold text-white mb-4">Smart Upload</h3>
              <p className="text-gray-400">
                Drag & drop up to 40 videos. Auto-generates thumbnails, extracts metadata, 
                and organizes everything intelligently.
              </p>
            </motion.div>
            
            <motion.div
              className="bg-gray-800 p-8 rounded-2xl border border-gray-700"
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.2 }}
              viewport={{ once: true }}
            >
              <div className="w-12 h-12 bg-green-600 rounded-lg flex items-center justify-center mb-6">
                <Users className="w-6 h-6 text-white" />
              </div>
              <h3 className="text-xl font-semibold text-white mb-4">Real-time Collaboration</h3>
              <p className="text-gray-400">
                See live cursor positions, instant variation selections, and 
                progress tracking across all connected users.
              </p>
            </motion.div>
          </div>
        </div>
      </section>

      {/* How it Works */}
      <section id="how-it-works" className="py-20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-white mb-4">Simple Workflow</h2>
            <p className="text-gray-400 text-lg">
              From upload to final approval in three easy steps
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
            <div className="text-center">
              <div className="w-16 h-16 bg-blue-600 rounded-full flex items-center justify-center mx-auto mb-6">
                <span className="text-2xl font-bold text-white">1</span>
              </div>
              <h3 className="text-xl font-semibold text-white mb-4">Upload & Organize</h3>
              <p className="text-gray-400">
                Upload your video variations using our intuitive drag & drop interface. 
                System automatically organizes and generates previews.
              </p>
            </div>
            
            <div className="text-center">
              <div className="w-16 h-16 bg-purple-600 rounded-full flex items-center justify-center mx-auto mb-6">
                <span className="text-2xl font-bold text-white">2</span>
              </div>
              <h3 className="text-xl font-semibold text-white mb-4">Invite & Collaborate</h3>
              <p className="text-gray-400">
                Send secure magic links to clients. No signup required. 
                They get instant access to review and select variations.
              </p>
            </div>
            
            <div className="text-center">
              <div className="w-16 h-16 bg-green-600 rounded-full flex items-center justify-center mx-auto mb-6">
                <span className="text-2xl font-bold text-white">3</span>
              </div>
              <h3 className="text-xl font-semibold text-white mb-4">Track & Finalize</h3>
              <p className="text-gray-400">
                Monitor progress in real-time. See selections as they happen. 
                Export final choices and move to post-production.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Performance Stats */}
      <section className="py-20 bg-gray-800/50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-white mb-4">Performance Targets</h2>
            <p className="text-gray-400 text-lg">
              Built for speed with enterprise-grade reliability
            </p>
          </div>
          
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            <div className="text-center">
              <div className="text-3xl font-bold text-blue-400 mb-2">< 100ms</div>
              <div className="text-gray-400">Clip Transitions</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-purple-400 mb-2">< 3s</div>
              <div className="text-gray-400">Load Time</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-green-400 mb-2">60fps</div>
              <div className="text-gray-400">Smooth Animations</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-yellow-400 mb-2">40+</div>
              <div className="text-gray-400">Video Support</div>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-4xl font-bold text-white mb-8">
            Ready to Transform Your Video Workflow?
          </h2>
          <p className="text-xl text-gray-300 mb-12">
            Join video production teams who've cut their review time from days to hours
          </p>
          
          <motion.button
            onClick={handleGetStarted}
            className="bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 text-white px-12 py-4 rounded-xl font-semibold text-lg transition-all duration-200"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            Start Your Free Trial
          </motion.button>
          
          <p className="text-gray-500 mt-6">
            No credit card required • Setup in under 5 minutes • Cancel anytime
          </p>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-gray-800 py-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center">
                <Zap className="w-5 h-5 text-white" />
              </div>
              <span className="text-xl font-bold text-white">Velocity</span>
            </div>
            
            <div className="flex items-center space-x-6">
              <a href="https://github.com/creativecgl/velocity-review-platform" 
                 className="text-gray-400 hover:text-white transition-colors flex items-center space-x-1"
                 target="_blank" rel="noopener noreferrer">
                <Github className="w-5 h-5" />
                <span>Open Source</span>
              </a>
              <div className="text-gray-500">
                Built with ❤️ for video production teams
              </div>
            </div>
          </div>
        </div>
      </footer>
    </div>
  )
}
