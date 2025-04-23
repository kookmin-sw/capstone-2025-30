const path = require("path");

module.exports = {
  webpack: {
    alias: {
      "@/": path.resolve(__dirname, "src"),
      "@/assets": path.resolve(__dirname, "src/assets"),
      "@/components": path.resolve(__dirname, "src/components"),
      "@/pages": path.resolve(__dirname, "src/pages"),
      "@/styles": path.resolve(__dirname, "src/styles"),
      // config랑 context 별칭 설정이 안 됨
      "@/config": path.resolve(__dirname, "src/config"),
      "@/context": path.resolve(__dirname, "src/context"),
    },
  },
};
