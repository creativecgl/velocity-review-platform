import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Velocity Review Platform',
  description: 'Professional video review platform with seamless collaboration',
  openGraph: {
    title: 'Velocity Review Platform',
    description: 'Professional video review platform with seamless collaboration',
    url: 'https://velocity-review-platform-cgls-projects.vercel.app',
    siteName: 'Velocity',
    images: [
      {
        url: 'https://velocity-review-platform-cgls-projects.vercel.app/og-image.png',
        width: 1200,
        height: 630,
      },
    ],
    locale: 'en_US',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Velocity Review Platform',
    description: 'Professional video review platform with seamless collaboration',
    images: ['https://velocity-review-platform-cgls-projects.vercel.app/og-image.png'],
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  )
}
