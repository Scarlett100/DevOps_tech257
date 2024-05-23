# Use an official node 20 as a parent image
FROM node:20
 
# Set the working directory in the container
WORKDIR /app

# 
COPY package*.json ./
 
# Copy the current directory contents into the container at /app
COPY . .
 
# Install npm packages
RUN npm install

# have a user
USER node


# Make port 3000 available to the world outside this container
EXPOSE 3000
 
 
# Run the app with PM2 when the container launches
CMD node app.js


# NOTES FOR MYSELF
# docker images -a
# to build "docker build --tag northwind_app ."

# docker build --tag northwind_app .

# docker run -p 5000:5000 northwind_app
# INFO:waitress:Serving on http://0.0.0.0:5000


# copy package.json
# COPY app/package*.json ./