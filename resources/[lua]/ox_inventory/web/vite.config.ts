import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react({
      babel: {
        plugins: [
          ['@babel/plugin-transform-react-jsx', { runtime: 'automatic' }]
        ]
      }
    })
  ],
  base: './',
  publicDir: false,
  build: {
    outDir: 'build',
    target: 'esnext',
    chunkSizeWarningLimit: 1000,
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true,
        pure_funcs: ['console.log', 'console.info'],
        passes: 2
      },
      mangle: {
        safari10: true
      },
      format: {
        comments: false
      }
    },
    rollupOptions: {
      output: {
        manualChunks: {
          'vendor-react': ['react', 'react-dom', 'react-redux'],
          'vendor-dnd': ['react-dnd', 'react-dnd-touch-backend'],
          'vendor-ui': ['@mantine/core', '@mantine/hooks', '@floating-ui/react']
        },
        assetFileNames: 'assets/[name].[hash][extname]',
        chunkFileNames: 'assets/[name].[hash].js',
        entryFileNames: 'assets/[name].[hash].js'
      }
    },
    reportCompressedSize: false,
    cssCodeSplit: true
  },
  define: {
    'process.env': {},
  },
  esbuild: {
    logOverride: { 'this-is-undefined-in-esm': 'silent' },
    legalComments: 'none',
    treeShaking: true
  },
  optimizeDeps: {
    include: ['react', 'react-dom', 'react-redux', '@mantine/core', '@mantine/hooks']
  }
});
