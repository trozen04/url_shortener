# URL Shortener
A modern URL shortening service with analytics tracking capabilities.


## Features
- Convert long URLs into shorter, shareable links
- Track clicks and engagement metrics
- Real-time analytics dashboard
- Clean, responsive interface
- Modular architecture for scalability

## Installation
```bash
git clone https://github.com/trozen04/url_shortener.git
cd client
npm install
cd ../server
npm install
```

## Getting Started
1. Start the server:
```bash
cd server
npm start
```
2. Launch the client:
```bash
cd client
npm start
```

## API Documentation
### Create Shortened URL
```http
POST /api/urls HTTP/1.1
Content-Type: application/json

{
  "originalUrl": "https://example.com/very/long/url"
}
```

### Get Original URL
```http
GET /api/urls/:shortId HTTP/1.1
```

## Contributing
Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request
4. Ensure all tests pass

## License
MIT License

Copyright (c) [2025] [Bhoopendra]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
